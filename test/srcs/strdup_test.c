/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strdup_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 21:49:03 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 22:25:28 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strdup_test(char *str)
{
	char	*ret[2];

	printf("-----\"%s\"-----\n", str);
	ret[0] = strdup(str);
	ret[1] = ft_strdup(str);
	if (!strcmp(ret[0], ret[1]))
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strdup    : %s\n", ret[0]);
	printf("ft_strdup : %s\n\n", ret[1]);
	free(ret[0]);
	free(ret[1]);
}

void		strdup_tests(void)
{
	printf("\n<<<<<<<<<<<< ft_strcpy.s >>>>>>>>>>>>\n");
	strdup_test("abc");
	strdup_test("");
	strdup_test("Hello, 42Tokyo");
	strdup_test("Hello\0, 42Tokyo");
	strdup_test("Zero-extention means the upper bits of the destination operand will be set to zero, while sign-extension means the upper bits of the destination operand will be set to the sign bit of the source operand.");
	strdup_test("                  ");
}
