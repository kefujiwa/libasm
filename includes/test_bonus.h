/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_bonus.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/20 15:03:38 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/22 02:25:20 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef TEST_BONUS_H
# define TEST_BONUS_H

/*
** SELF-MADE HEADER FILES
*/
# include "libasm_bonus.h"

/*
** EXTERNAL LIBRARIES
*/
# include <stdio.h>
# include <stdlib.h>
# include <string.h>

/*
** MACRO DECLARATION (COLORS)
*/
# define RESET	"\x1b[0m"
# define RED	"\x1b[31m"
# define GREEN	"\x1b[32m"
# define YELLOW "\x1b[33m"

/*
** PROTOTYPE DECLARATION
*/
void	atoi_base_tests(int *result);
void	list_push_front_tests(int *result);
void	list_remove_if_tests(int *result);
void	list_size_tests(int *result);
void	list_sort_tests(int *result);

void	list_add_back(t_list **lst, t_list *new);
void	list_clear(t_list **lst, void (*del)(void*));
void	list_delone(t_list *lst, void (*del)(void*));
t_list	*list_last(t_list *lst);
t_list	*list_new(void *data);
int		list_size(t_list *begin_list);
void	print_list(t_list *lst);
void	print_lists(char *name, t_list *list, t_list *ft_list, int *result, int is_ok);

#endif
