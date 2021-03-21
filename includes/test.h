/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 16:52:00 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 16:18:42 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef TEST_H
# define TEST_H

/*
** SELF-MADE HEADER FILES
*/
# include "libasm.h"

/*
** EXTERNAL LIBRARIES
*/
# include <fcntl.h>
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <unistd.h>

/*
** MACRO DECLARATION (COLORS)
*/
# define RESET	"\x1b[0m"
# define RED	"\x1b[31m"
# define GREEN	"\x1b[32m"

/*
** MACRO DECLARATION (BUFFER_SIZE)
*/
# define BUFFER_SIZE 1024

/*
** PROTOTYPE DECLARATION
*/
void	read_tests(int *result);
void	strcmp_tests(int *result);
void	strcpy_tests(int *result);
void	strdup_tests(int *result);
void	strlen_tests(int *result);
void	write_tests(int *result);

#endif
