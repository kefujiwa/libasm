/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_push_front_test.c                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 19:00:15 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 01:49:18 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

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

static void	list_init(t_list **list)
{
	*list = NULL;
	list_add_back(list, list_new(strdup("test1")));
	list_add_back(list, list_new(strdup("test2")));
}

static void	list_push_front_test(void *new, int *result)
{
	t_list	*list;
	t_list	*ft_list;
	int		size;

	result[0] += 1;
	list_init(&list);
	if (new)
		list_push_front(&list, strdup(new));
	else
		list_push_front(&list, new);
	list_init(&ft_list);
	if (new)
		ft_list_push_front(&ft_list, strdup(new));
	else
		ft_list_push_front(&ft_list, new);
	printf("-----list_push_front(list," YELLOW " \"%s\"" RESET ")-----\n", (char*)new);
	if ((size = list_size(list)) == list_size(ft_list))
	{
		while (size--)
		{
			if (!list->data && !ft_list->data)
				continue ;
			if (strcmp(list->data, ft_list->data))
			{
				print_lists("list_push_front", list, ft_list, result, 0);
				return ;
			}
		}
		print_lists("list_push_front", list, ft_list, result, 1);
	}
	else
		print_lists("list_push_front", list, ft_list, result, 0);
	list_clear(&list, free);
	list_clear(&ft_list, free);
}

void		list_push_front_tests(int *result)
{
	t_list	*list;

	list_init(&list);
	printf("\n<<<<<<<<<<<< ft_list_push_front.s >>>>>>>>>>>>\n");
	printf("BEFORE>>>\n" YELLOW "");
	print_list(list);
	list_clear(&list, free);
	printf("" RESET "\n\nAFTER>>>\n");
	list_push_front_test(strdup("4242"), result);
	list_push_front_test(strdup(""), result);
	list_push_front_test(strdup("HELLO, 42TOKYO"), result);
	list_push_front_test(NULL, result);
}
