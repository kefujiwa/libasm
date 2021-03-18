/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kefujiwa <kefujiwa@student.42tokyo.jp>     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/03/18 18:25:33 by kefujiwa          #+#    #+#             */
/*   Updated: 2021/03/19 00:03:04 by kefujiwa         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "libasm.h"

void	write_test(char *str)
{
	int		fd[2];
	char	buf[BUFFER_SIZE];
	char	ft_buf[BUFFER_SIZE];
	int		ret[4];

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

void	write_test_err(int fd, char *str, int len)
{
	int	ret[2];
	int	err[2];

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

void	read_test(char *str)
{
	int		fd[2];
	char	buf[BUFFER_SIZE];
	char	ft_buf[BUFFER_SIZE];
	int		ret[2];

	printf("-----\"%s\"-----\n", str);
	bzero(buf, BUFFER_SIZE);
	bzero(ft_buf, BUFFER_SIZE);
	fd[0] = open("./test/read.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	fd[1] = open("./test/ft_read.txt", O_CREAT | O_RDWR | O_TRUNC, S_IRUSR | S_IWUSR);
	write(fd[0], str, strlen(str));
	write(fd[1], str, strlen(str));
	lseek(fd[0], 0, SEEK_SET);
	lseek(fd[1], 0, SEEK_SET);
	ret[0] = read(fd[0], buf, BUFFER_SIZE);
	buf[ret[0]] = 0;
	ret[1] = ft_read(fd[1], ft_buf, BUFFER_SIZE);
	ft_buf[ret[1]] = 0;
	if (!strcmp(buf, ft_buf) && ret[0] == ret[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("read    [%d] : %s\n",  ret[0], buf);
	printf("ft_read [%d] : %s\n\n", ret[1], ft_buf);
	close(fd[0]);
	close(fd[1]);
}

void	read_test_err(int fd, char *buf, int size)
{
	int		ret[2];
	int		err[2];
	char	buffer[BUFFER_SIZE];
	char	*tmp;

	tmp = NULL;
	if (buf)
		tmp = buffer;;
	if (!fd)
		fd = open("./Makefile", O_RDONLY);
	printf("-----read(%d, %s, %d)-----\n", fd, buf, size);
	ret[0] = read(fd, tmp, size);
	err[0] = errno;
	ret[1] = ft_read(fd, tmp, size);
	err[1] = errno;
	if (ret[0] == ret[1] && err[0] == err[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("read    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_read [%d] : errno > %d\n\n", ret[1], err[1]);
}

void	strlen_test(char *str)
{
	int	ret[2];
	int	err[2];

	errno = 0;
	printf("-----strlen(%s)-----\n", str);
	ret[0] = strlen(str);
	err[0] = errno;
	ret[1] = ft_strlen(str);
	err[1] = errno;
	if (ret[0] == ret[1])
		printf("" GREEN "[OK]" RESET "\n");
	else
		printf("" RED "[KO]" RESET "\n");
	printf("strlen    [%d] : errno > %d\n", ret[0], err[0]);
	printf("ft_strlen [%d] : errno > %d\n\n", ret[1], err[1]);
}


int		main(void)
{
	/*
	** FT_WRITE
	*/
	printf("============ Start Test ============\n\n");
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

	/*
	** FT_READ
	*/
	printf("\n<<<<<<<<<<<< ft_read.s >>>>>>>>>>>>\n");
	read_test("42");
	read_test("Born2Code");
	read_test("Born2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2CodeBorn2Code");
	read_test("");
	read_test_err(0, "buf", 0);
	read_test_err(-1, "buf", BUFFER_SIZE);
	read_test_err(100, "buf", BUFFER_SIZE);
	read_test_err(0, NULL, BUFFER_SIZE);
	read_test_err(0, "buf", -1);
	read_test_err(-1, NULL, -1);

	
	/*
	** FT_STRLEN
	*/
	printf("\n<<<<<<<<<<<< ft_strlen.s >>>>>>>>>>>>\n");
	strlen_test("42");
	strlen_test("");
	strlen_test("Done is better than perfect");
	strlen_test("          ");
	strlen_test("hey yo\0aaaaaaaa");
	strlen_test("To be or not to be, that is the question. The original meaning of this character was like NOP—when sent to a printer or a terminal, it does nothing (some terminals, however, incorrectly display it as space).");
}
