/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_bonus.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/18 18:25:33 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 16:30:01 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test_bonus.h"

int		main(void)
{
	int	result[2];

	result[0] = 0;
	result[1] = 0;
	printf("============ Start Test ============\n\n");
	atoi_base_tests(result);
	printf("============ RESULT ============\n\n");
	if (result[0] == result[1])
		printf("" GREEN "[ALL OK]\n" RESET "");
	else
		printf("" RED "[KO]\n" RESET "");
	printf("%d / %d\n\n", result[1], result[0]);
	printf("================================\n\n");
}
