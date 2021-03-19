/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   libasm.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/18 18:19:59 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 17:28:56 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef LIBASM_H
# define LIBASM_H

/*
** EXTERNAL LIBRARIES
*/
# include <errno.h>
# include <stdlib.h>
# include <unistd.h>

/*
** PROTOTYPE DECLARATION
*/
int		ft_strcmp(const char *s1, const char *s2);
size_t	ft_strlen(const char *s);
ssize_t	ft_read(int fildes, void *buf, size_t nbyte);
ssize_t	ft_write(int fildes, const void *buf, size_t nbyte);

#endif
