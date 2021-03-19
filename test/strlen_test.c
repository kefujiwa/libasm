/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlen_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 17:16:01 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 17:31:32 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strlen_test(char *str)
{
	int	ret[2];
	int	err[2];

	errno = 0;
	printf("-----strlen(%s)-----\n", str);
	ret[0] = strlen(str);
	err[0] = errno;
	ret[1] = ft_strlen(str);
	err[1] = errno;
	if (ret[0] == ret[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strlen    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_strlen [%d] : errno > %d\n\n", ret[1], err[1]);
}

void		strlen_tests(void)
{
	printf("\n<<<<<<<<<<<< ft_strlen.s >>>>>>>>>>>>\n");
	strlen_test("42");
	strlen_test("");
	strlen_test("Done is better than perfect");
	strlen_test("          ");
	strlen_test("hey yo\0aaaaaaaa");
	strlen_test("To be or not to be, that is the question. The original meaning of this character was like NOP—when sent to a printer or a terminal, it does nothing (some terminals, however, incorrectly display it as space).");
}
