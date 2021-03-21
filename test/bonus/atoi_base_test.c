/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   atoi_base_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/20 14:56:37 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 14:07:39 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

static int		is_space(char c)
{
	return (c == '\t' || c == '\n' || c == '\v'
			|| c == '\f' || c == '\r' || c == ' ');
}

static int		is_valid_base(char *base)
{
	char	*tmp;

	if (!base || !*base || !*(base + 1))
		return (0);
	while (*base)
	{
		if (*base == '-' || *base == '+' || is_space(*base))
			return (0);
		tmp = base + 1;
		while (*tmp)
		{
			if (*base == *tmp)
				return (0);
			tmp++;
		}
		base++;
	}
	return (1);
}

static int		get_value(char c, char *base)
{
	char	*head;

	head = base;
	while (*base)
	{
		if (*base == c)
			return (base - head);
		base++;
	}
	return (-1);
}

static int		atoi_base(char *str, char *base)
{
	int	total;
	int	sign;
	int	val;

	total = 0;
	sign = 1;
	if (!is_valid_base(base))
		return (0);
	while (is_space(*str))
		str++;
	while (*str == '-' || *str == '+')
	{
		if (*str == '-')
			sign *= -1;
		str++;
	}
	while ((val = get_value(*str, base)) >= 0)
	{
		total = total * strlen(base) + val;
		str++;
	}
	return (total * sign);
}

static void		atoi_base_test(char *str, char *base)
{
	int 	ret[2];

	printf("-----atoi_base(\"%s\", \"%s\")-----\n", str, base);
	ret[0] = atoi_base(str, base);
	ret[1] = ft_atoi_base(str, base);
	if (ret[0] == ret[1])
		printf("" GREEN "[OK] " RESET "\n");
	else
		printf("" RED "[KO] " RESET "\n");
	printf("atoi_base    : %d\n", ret[0]);
	printf("ft_atoi_base : %d\n\n", ret[1]);
}

void			atoi_base_tests(void)
{
	printf("\n<<<<<<<<<<<< atoi_base.s >>>>>>>>>>>>\n");
	atoi_base_test("2147483647", "0123456789");
	atoi_base_test("", "0123456789");
	atoi_base_test("2147483647", "011");
	atoi_base_test("18f", "0123456789abcdef");
	atoi_base_test("18fb52", "0123456789");
	atoi_base_test("18f", "");
	atoi_base_test("101", "1");
	atoi_base_test("45", "");
	atoi_base_test("45", "0");
	atoi_base_test("--2147483647", "0123456789");
	atoi_base_test("      ++++---2147483647", "0123456789");
	atoi_base_test("--2147483648", "0123456789");
	atoi_base_test("--2147483647", "0123456789-");
	atoi_base_test("-2147483647", "0123456789-");
	atoi_base_test(" \t--\t-2147483647", "0123456789");
	atoi_base_test("  -+\v++-\t--2147483647", "0123456789");
}
