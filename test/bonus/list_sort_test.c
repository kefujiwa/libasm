/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_sort_test.c                                   :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/22 02:25:35 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 22:32:47 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

static t_list	*merge(t_list *a, t_list *b, int (*f)(void*, void*))
{
	t_list	result;
	t_list	*y;
	t_list	*x;

	y = &result;
	x = &result;
	while (a != NULL && b != NULL)
	{
		if (f(a->data, b->data) > 0)
		{
			x->next = b;
			x = x->next;
			b = b->next;
		}
		else
		{
			x->next = a;
			x = x->next;
			a = a->next;
		}
	}
	if (a == NULL)
		x->next = b;
	else
		x->next = a;
	return (result.next);
}

static t_list	*merge_sort(t_list *lst, int (*f)(void*, void*))
{
	t_list	*a;
	t_list	*b;
	t_list	*x;

	if (!lst || !lst->next)
		return (lst);
	a = lst;
	b = lst->next;
	if (b != NULL)
		b = b->next;
	while (b != NULL)
	{
		a = a->next;
		b = b->next;
		if (b != NULL)
			b = b->next;
	}
	x = a->next;
	a->next = NULL;
	return (merge(merge_sort(lst, f), merge_sort(x, f), f));
}

static void		list_sort(t_list **begin_list, int (*cmp)())
{
	if (!begin_list || !*begin_list)
		return ;
	*begin_list = merge_sort(*begin_list, cmp);
}

static void		list_sort_test(t_list **list, t_list **ft_list, int *result)
{
	int	size;

	result[0] += 1;
	printf("--------------------\n");
	printf("BEFORE>>>\n" YELLOW "");
	print_list(*list);
	printf("" RESET "\n\nAFTER>>>\n");
	list_sort(list, strcmp);
	ft_list_sort(ft_list, strcmp);
	if ((size = list_size(*list)) == list_size(*ft_list))
	{
		while (size--)
		{
			if (!(*list)->data && !(*ft_list)->data)
				continue ;
			if (strcmp((*list)->data, (*ft_list)->data))
			{
				print_lists("list_sort", *list, *ft_list, result, 0);
				return ;
			}
		}
		print_lists("list_sort", *list, *ft_list, result, 1);
	}
	else
		print_lists("list_sort", *list, *ft_list, result, 0);
	list_clear(list, free);
	list_clear(ft_list, free);
}

static void		list_init1(t_list **list)
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

static void		list_init2(t_list **list)
{
	*list = NULL;
	list_add_back(list, list_new(strdup("5")));
	list_add_back(list, list_new(strdup("5")));
	list_add_back(list, list_new(strdup("5")));
	list_add_back(list, list_new(strdup("2")));
	list_add_back(list, list_new(strdup("0")));
	list_add_back(list, list_new(strdup("1")));
	list_add_back(list, list_new(strdup("7")));
}

static void		list_init3(t_list **list)
{
	*list = NULL;
	list_add_back(list, list_new(strdup("109")));
	list_add_back(list, list_new(strdup("234")));
	list_add_back(list, list_new(strdup("900000")));
	list_add_back(list, list_new(strdup("098")));
	list_add_back(list, list_new(strdup("1345")));
	list_add_back(list, list_new(strdup("----")));
	list_add_back(list, list_new(strdup("~~~~")));
}

void			list_sort_tests(int *result)
{
	t_list	*list;
	t_list	*ft_list;

	printf("\n<<<<<<<<<<<< ft_list_sort.s >>>>>>>>>>>>\n");
	list_init1(&list);
	list_init1(&ft_list);
	list_sort_test(&list, &ft_list, result);

	list_init2(&list);
	list_init2(&ft_list);
	list_sort_test(&list, &ft_list, result);

	list_init3(&list);
	list_init3(&ft_list);
	list_sort_test(&list, &ft_list, result);
}
