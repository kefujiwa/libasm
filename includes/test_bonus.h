/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test_bonus.h                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/20 15:03:38 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/20 15:42:42 by kefujiwa         ###   ########.fr       */
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
void	atoi_base_tests(void);

#endif
