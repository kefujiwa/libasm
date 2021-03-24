/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strlen_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 17:16:01 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/25 03:15:22 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strlen_test(char *str, int *result)
{
	int	ret[2];

	result[0] += 1;
	printf("-----strlen(%s)-----\n", str);
	ret[0] = strlen(str);
	ret[1] = ft_strlen(str);
	if (ret[0] == ret[1])
	{
		printf("" GREEN "[OK]" RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strlen    : return  > %d\n", ret[0]);
	printf("ft_strlen : return  > %d\n\n", ret[1]);
}

void		strlen_tests(int *result)
{
	printf("\n<<<<<<<<<<<< ft_strlen.s >>>>>>>>>>>>\n");
	strlen_test("42", result);
	strlen_test("", result);
	strlen_test("Done is better than perfect", result);
	strlen_test("          ", result);
	strlen_test("hey yo\0aaaaaaaa", result);
	strlen_test("To be or not to be, that is the question. The original meaning of this character was like NOP—when sent to a printer or a terminal, it does nothing (some terminals, however, incorrectly display it as space).", result);
}
