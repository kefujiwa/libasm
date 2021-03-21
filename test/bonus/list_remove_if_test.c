/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_remove_if_test.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 20:56:02 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 01:48:49 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

void		list_remove_if(t_list **begin_list, void *data_ref,
								int (*cmp)(), void (*free_fct)(void *))
{
	t_list	*list;
	t_list	*next;
	t_list	*prev;

	list = *begin_list;
	next = NULL;
	prev = NULL;
	if (!begin_list || !data_ref || !cmp || !free_fct)
		return ;
	while (list)
	{
		next = list->next;
		if (list->data && !cmp(list->data, data_ref))
		{
			free_fct(list->data);
			free_fct(list);
			list = NULL;
			if (prev)
				prev->next = next;
			else
				*begin_list = next;
		}
		if (list)
			prev = list;
		list = next;
	}
}

static void	list_init(t_list **list)
{
	*list = NULL;
	list_add_back(list, list_new(strdup("test")));
	list_add_back(list, list_new(strdup("hello")));
	list_add_back(list, list_new(strdup("42")));
	list_add_back(list, list_new(strdup("")));
	list_add_back(list, list_new(strdup("hello")));
	list_add_back(list, list_new(strdup("hahaha")));
	list_add_back(list, list_new(strdup("hahaha")));
}

static void	list_remove_if_test(void *data_ref, int *result)
{
	t_list	*list;
	t_list	*ft_list;
	int		size;

	result[0] += 1;
	list_init(&list);
	list_remove_if(&list, data_ref, strcmp, free);
	list_init(&ft_list);
	ft_list_remove_if(&ft_list, data_ref, strcmp, free);
	printf("-----list_remove_if(list," YELLOW " \"%s\"" RESET ", strcmp, free)-----\n", (char*)data_ref);
	if ((size = list_size(list)) == list_size(ft_list))
	{
		while (size--)
		{
			if (!list->data && !ft_list->data)
				continue ;
			if (strcmp(list->data, ft_list->data))
			{
				print_lists("list_remove_if", list, ft_list, result, 0);
				return ;
			}
		}
		print_lists("list_remove_if", list, ft_list, result, 1);
	}
	else
		print_lists("list_remove_if", list, ft_list, result, 0);
	list_clear(&list, free);
	list_clear(&ft_list, free);
}

void		list_remove_if_tests(int *result)
{
	t_list	*list;

	list_init(&list);
	printf("\n<<<<<<<<<<<< ft_list_remove_if.s >>>>>>>>>>>>\n");
	printf("BEFORE>>>\n" YELLOW "");
	print_list(list);
	list_clear(&list, free);
	printf("" RESET "\n\nAFTER>>>\n");
	list_remove_if_test("test", result);
	list_remove_if_test("hello", result);
	list_remove_if_test("42", result);
	list_remove_if_test("", result);
	list_remove_if_test("hahaha", result);
	list_remove_if_test("adios", result);
}
