/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/18 18:25:33 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/20 16:05:29 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

int		main(void)
{
	printf("============ Start Test ============\n\n");
	write_tests();
	read_tests();
	strlen_tests();
	strcmp_tests();
	strcpy_tests();
	strdup_tests();
}
