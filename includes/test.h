/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 16:52:00 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 21:48:44 by kefujiwa         ###   ########.fr       */
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
void	read_tests(void);
void	strcmp_tests(void);
void	strcpy_tests(void);
void	strdup_tests(void);
void	strlen_tests(void);
void	write_tests(void);

#endif
