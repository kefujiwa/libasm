/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_size_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 16:36:27 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 18:18:18 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

static int	list_size(t_list *lst)
{
	int	cnt;

	cnt = 0;
	while (lst)
	{
		cnt++;
		lst = lst->next;
	}
	return (cnt);
}

static int	list_size_test(int size, int *result)
{
	t_list	*list;
	int		ret[2];

	result[0] += 1;
	list = NULL;
	while (size--)
		list_add_back(&list, list_new(&size));
	ret[0] = list_size(list);
	ret[1] = ft_list_size(list);
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
