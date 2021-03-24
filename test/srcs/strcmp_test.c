/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   strcmp_test.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 17:19:27 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/24 23:37:44 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	strcmp_test(char *s1, char *s2, int *result, char *content)
{
	int	ret[2];

	result[0] += 1;
	if (!content)
		printf("-----strcmp(\"%s\", \"%s\")-----\n", s1, s2);
	else
		printf("-----strcmp(\"%s\")-----\n", content);
	ret[0] = strcmp(s1, s2);
	ret[1] = ft_strcmp(s1, s2);
	if (ret[0] == ret[1])
	{
		printf("" GREEN "[OK]" RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strcmp    : return > %d \n", ret[0]);
	printf("ft_strcmp : return > %d\n\n", ret[1]);
}

void		strcmp_tests(int *result)
{
	printf("\n<<<<<<<<<<<< ft_strcmp.s >>>>>>>>>>>>\n");
	strcmp_test("", "42", result, NULL);
	strcmp_test("42", "", result, NULL);
	strcmp_test("42", "42", result, NULL);
	strcmp_test("42", "4", result, NULL);
	strcmp_test("4", "42", result, NULL);
	strcmp_test("Hello, World!", "Hello, World!!!!!!!!!!!!!!", result, NULL);
	strcmp_test("\xff\xff", "\xff\xfe", result, "\\xff\\xff\", \"\\xff\\xfe");
	strcmp_test("\xff\xfe", "\xff\xff", result, "\\xff\\xfe\", \"\\xff\\xff");
	strcmp_test("\xff\xff", "\xff\x30", result, "\\xff\\xff\", \"\\xff\\x30");
	strcmp_test("\xff\x30", "\xff\xff", result, "\\xff\\xff\", \"\\xff\\x30");
	strcmp_test("\xff\xff", "\xff", result, "\\xff\\xff\", \"\\xff");
}
