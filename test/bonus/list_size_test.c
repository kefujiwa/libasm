/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_size_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 16:36:27 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 22:28:02 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

int			list_size(t_list *begin_list)
{
	int	cnt;

	cnt = 0;
	while (begin_list)
	{
		cnt++;
		begin_list = begin_list->next;
	}
	return (cnt);
}

static int	list_size_test(int size, int *result)
{
	t_list	*list;
	int		tmp;
	int		ret[2];

	result[0] += 1;
	list = NULL;
	tmp	= size;
	while (tmp--)
		list_add_back(&list, list_new(strdup("42")));
	ret[0] = list_size(list);
	ret[1] = ft_list_size(list);
	list_clear(&list, free);
	printf("-----list_size(" YELLOW "%d" RESET ")-----\n", size);
	if (ret[0] == ret[1])
	{
		printf("" GREEN "[OK] " RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO] " RESET "\n");
	printf("list_size    : %d\n", ret[0]);
	printf("ft_list_size : %d\n\n", ret[1]);
	return (1);
}

void		list_size_tests(int *result)
{
	printf("\n<<<<<<<<<<<< ft_list_size.s >>>>>>>>>>>>\n");
	list_size_test(0, result);
	list_size_test(1, result);
	list_size_test(8, result);
	list_size_test(16, result);
}
