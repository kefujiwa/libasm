/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcmp_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 17:19:27 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 17:31:48 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strcmp_test(char *s1, char *s2)
{
	int	ret[2];
	int	err[2];

	errno = 0;
	printf("-----strcmp(%s, %s)-----\n", s1, s2);
	ret[0] = strcmp(s1, s2);
	err[0] = errno;
	ret[1] = ft_strcmp(s1, s2);
	err[1] = errno;
	if (ret[0] == ret[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strcmp    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_strcmp [%d] : errno > %d\n\n", ret[1], err[1]);
}

void		strcmp_tests(void)
{
	printf("\n<<<<<<<<<<<< ft_strcmp.s >>>>>>>>>>>>\n");
	strcmp_test("42", "42");
	strcmp_test("42", "4");
	strcmp_test("4", "42");
	strcmp_test("Hello, World!", "Hello, World!!!!!!!!!!!!!!");
}
