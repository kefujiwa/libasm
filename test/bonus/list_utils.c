/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   list_utils.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/21 18:13:56 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 01:09:41 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

t_list	*list_new(void *data)
{
	t_list	*lst;

	lst = (t_list*)malloc(sizeof(t_list));
	if (!lst)
		return (NULL);
	lst->data = data;
	lst->next = NULL;
	return (lst);
}

t_list	*list_last(t_list *lst)
{
	if (!lst)
		return (NULL);
	while (lst->next)
		lst = lst->next;
	return (lst);
}

void	list_add_back(t_list **lst, t_list *new)
{
	t_list	*tmp;

	if (!lst || !new)
		return ;
	if (*lst)
	{
		tmp = list_last(*lst);
		tmp->next = new;
	}
	else
		*lst = new;
}

void	print_list(t_list *lst)
{
	while (lst)
	{
		printf("\"%s\" ", lst->data);
		lst = lst->next;
	}
}

void	print_lists(char *name, t_list *list, t_list *ft_list, int *result, int is_ok)
{
	if (is_ok)
	{
		printf("" GREEN "[OK] " RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO] " RESET "\n");
	printf("%s:    ", name);
	print_list(list);
	printf("\nft_%s: ", name);
	print_list(ft_list);
	printf("\n\n");
}

void	list_clear(t_list **lst, void (*del)(void*))
{
	t_list	*next;

	if (!lst || !del)
		return ;
	while (*lst)
	{
		next = (*lst)->next;
		list_delone(*lst, del);
		*lst = next;
	}
}

void	list_delone(t_list *lst, void (*del)(void*))
{
	if (!lst || !del)
		return ;
	if (lst->data)
		del(lst->data);
	free(lst);
}
