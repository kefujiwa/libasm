/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   write_test.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 10:56:18 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 17:15:47 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void    write_test(char *str)
{
	int     fd[2];
	char    buf[BUFFER_SIZE];
	char    ft_buf[BUFFER_SIZE];
	int     ret[4];

	printf("-----write(1, \"%s\", %lu)-----\n", str, strlen(str));
	bzero(buf, BUFFER_SIZE);
	bzero(ft_buf, BUFFER_SIZE);
	fd[0] = open("./test/write.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	fd[1] = open("./test/ft_write.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	ret[0] = write(fd[0], str, strlen(str));
	ret[1] = ft_write(fd[1], str, strlen(str));
	lseek(fd[0], 0, SEEK_SET);
	lseek(fd[1], 0, SEEK_SET);
	ret[2] = read(fd[0], buf, BUFFER_SIZE);
	buf[ret[2]] = 0;
	ret[3] = read(fd[1], ft_buf, BUFFER_SIZE);
	ft_buf[ret[3]] = 0;
	if (!strcmp(buf, ft_buf) && ret[0] == ret[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("write    [%d] : %s\n",  ret[0], buf);
	printf("ft_write [%d] : %s\n\n", ret[1], ft_buf);
	close(fd[0]);
	close(fd[1]);
}

static void    write_test_err(int fd, char *str, int len)
{
	int ret[2];
	int err[2];

	printf("-----write(%d, \"%s\", %d)-----\n", fd, str, len);
	ret[0] = write(fd, str, len);
	err[0] = errno;
	ret[1] = ft_write(fd, str, len);
	err[1] = errno;
	if (ret[0] == ret[1] && err[0] == err[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("write    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_write [%d] : errno > %d\n\n", ret[1], err[1]);
}

void		write_tests(void)
{
	printf("<<<<<<<<<<<< ft_write.s >>>>>>>>>>>>\n");
	write_test("42");
	write_test("Born2Code");
	write_test("Born2\0Code");
	write_test("Born2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2Code");
	write_test("");
	write_test_err(1, "hello", 0);
	write_test_err(-1, "hello", 5);
	write_test_err(100, "hello", 5);
	write_test_err(1, NULL, 1);
	write_test_err(1, "hello", -1);
	write_test_err(-1, NULL, -1);
}