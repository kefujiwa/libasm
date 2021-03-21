/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm_bonus.h                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/20 02:37:07 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/20 02:43:06 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_BONUS_H
# define LIBASM_BONUS_H

/*
** SELF-MADE HEADER FILES
*/
# include "libasm.h"

/*
** STRUCTURE
*/
typedef struct	s_list
{
	void	*data;
	struct	s_list *next;
}				t_list;

/*
** PROTOTYPE DECLARATION
*/
int				ft_atoi_base(char *str, char *base);

#endif
