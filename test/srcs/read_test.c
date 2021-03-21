/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   read_test.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/19 17:11:58 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/21 16:27:05 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "test.h"

static void	read_test(char *str, int *result)
{
	int		fd[2];
	char	buf[BUFFER_SIZE];
	char	ft_buf[BUFFER_SIZE];
	int		ret[2];

	result[0] += 1;
	printf("-----\"%s\"-----\n", str);
	bzero(buf, BUFFER_SIZE);
	bzero(ft_buf, BUFFER_SIZE);
	fd[0] = open("./test/srcs/read.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	fd[1] = open("./test/srcs/ft_read.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	write(fd[0], str, strlen(str));
	write(fd[1], str, strlen(str));
	lseek(fd[0], 0, SEEK_SET);
	lseek(fd[1], 0, SEEK_SET);
	ret[0] = read(fd[0], buf, BUFFER_SIZE);
	buf[ret[0]] = 0;
	ret[1] = ft_read(fd[1], ft_buf, BUFFER_SIZE);
	ft_buf[ret[1]] = 0;
	if (!strcmp(buf, ft_buf) && ret[0] == ret[1])
	{
		printf("" GREEN "[OK]" RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO]" RESET "\n");
	printf("read    [%d] : %s\n",  ret[0], buf);
	printf("ft_read [%d] : %s\n\n", ret[1], ft_buf);
	close(fd[0]);
	close(fd[1]);
}

static void	read_test_err(int fd, char *buf, int size, int *result)
{
	int		ret[2];
	int		err[2];

	result[0] += 1;
	if (!fd)
		fd = open("./Makefile", O_RDONLY);
	if (buf)
		printf("-----read(%d, buf, %d)-----\n", fd, size);
	else
		printf("-----read(%d, %s, %d)-----\n", fd, buf, size);
	errno = 0;
	ret[0] = read(fd, buf, size);
	err[0] = errno;
	errno = 0;
	ret[1] = ft_read(fd, buf, size);
	err[1] = errno;
	if (ret[0] == ret[1] && err[0] == err[1])
	{
		printf("" GREEN "[OK]" RESET "\n");
		result[1] += 1;
	}
	else
		printf("" RED "[KO]" RESET "\n");
	printf("read    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_read [%d] : errno > %d\n\n", ret[1], err[1]);
}

void		read_tests(int *result)
{
	char	buf[BUFFER_SIZE];

	printf("\n<<<<<<<<<<<< ft_read.s >>>>>>>>>>>>\n");
	read_test("42", result);
	read_test("Born2Code", result);
	read_test("Born2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2Code", result);
	read_test("", result);
	read_test_err(0, buf, 0, result);
	read_test_err(-1, buf, BUFFER_SIZE, result);
	read_test_err(100, buf, BUFFER_SIZE, result);
	read_test_err(0, NULL, BUFFER_SIZE, result);
	read_test_err(0, buf, -1, result);
	read_test_err(-1, NULL, -1, result);
}
