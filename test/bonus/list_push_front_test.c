/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_push_front_test.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 19:00:15 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 20:36:13 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

static void	print_lists(t_list *list, t_list *ft_list, int *result, int is_ok)
{
	if (is_ok)
	{
		printf("" GREEN "[OK] " RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO] " RESET "\n");
	printf("list_push_front:    ");
	print_list(list);
	printf("\nft_list_push_front: ");
	print_list(ft_list);
	printf("\n\n");
}		

static void	list_push_front(t_list **begin_list, void *data)
{
	t_list	*new;

	if (!begin_list)
		return ;
	if (!(new = list_new(data)))
		return ;
	new->next = *begin_list;
	*begin_list = new;
}

static void	list_push_front_test(void *new, int *result)
{
	t_list	*list;
	t_list	*ft_list;
	int		size;

	result[0] += 1;
	list = NULL;
	list_add_back(&list, list_new("test1"));
	list_add_back(&list, list_new("test2"));
	list_push_front(&list, new);
	ft_list = NULL;
	list_add_back(&ft_list, list_new("test1"));
	list_add_back(&ft_list, list_new("test2"));
	ft_list_push_front(&ft_list, new);
	printf("-----list_push_front(list, \"%s\")-----\n", (char*)new);
	if ((size = list_size(list)) == list_size(ft_list))
	{
		while (size--)
		{
			if (!list->data && !ft_list->data)
				continue ;
			if (strcmp(list->data, ft_list->data))
			{
				print_lists(list, ft_list, result, 0);
				return ;
			}
		}
		print_lists(list, ft_list, result, 1);
	}
	else
		print_lists(list, ft_list, result, 0);
}

void		list_push_front_tests(int *result)
{
	printf("\n<<<<<<<<<<<< ft_list_push_front.s >>>>>>>>>>>>\n");
	list_push_front_test(strdup("4242"), result);
	list_push_front_test(strdup(""), result);
	list_push_front_test(strdup("HELLO, 42TOKYO"), result);
	list_push_front_test(NULL, result);
}
