/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcpy_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 19:51:34 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 20:45:26 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strcpy_test(char *str)
{
	char	dst[BUFFER_SIZE];
	char	ft_dst[BUFFER_SIZE];
	char	*ret[2];

	printf("-----\"%s\"-----\n", str);
	bzero(dst, BUFFER_SIZE);
	bzero(ft_dst, BUFFER_SIZE);
	ret[0] = strcpy(dst, str);
	ret[1] = ft_strcpy(ft_dst, str);
	if (!strcmp(dst, ft_dst) && !strcmp(ret[0], ret[1]))
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strcpy    : dst > %s\n          : ret > %s\n", dst, ret[0]);
	printf("ft_strcpy : dst > %s\n          : ret > %s\n\n", ft_dst, ret[1]);
}

void		strcpy_tests(void)
{
	printf("\n<<<<<<<<<<<< ft_strcpy.s >>>>>>>>>>>>\n");
	strcpy_test("abc");
	strcpy_test("");
	strcpy_test("Hello, 42Tokyo");
	strcpy_test("Hello\0, 42Tokyo");
	strcpy_test("Zero-extention means the upper bits of the destination operand will be set to zero, while sign-extension means the upper bits of the destination operand will be set to the sign bit of the source operand.");
	strcpy_test("                  ");
}