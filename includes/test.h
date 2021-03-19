/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   test.h                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 16:52:00 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 19:51:27 by kefujiwa         ###   ########.fr       */
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
# define RESET	"\033[0m"
# define RED	"\033[31m"
# define GREEN	"\033[32m"

/*
** MACRO DECLARATION (BUFFER_SIZE)
*/
# define BUFFER_SIZE 1024

/*
** PROTOTYPE DECLARATION
*/
void	read_tests(void);
void	strcmp_tests(void);
void	strlen_tests(void);
void	write_tests(void);
void	strcpy_tests(void);

#endif
