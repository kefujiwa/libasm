/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_bonus.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/20 15:03:38 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 18:17:35 by kefujiwa         ###   ########.fr       */
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

/*
** PROTOTYPE DECLARATION
*/
void	atoi_base_tests(int *result);
void	list_size_tests(int *result);

void	list_add_back(t_list **lst, t_list *new);
t_list	*list_last(t_list *lst);
t_list	*list_new(void *data);

#endif
