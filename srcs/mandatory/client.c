/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nino <nino@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/09/09 14:15:18 by nino              #+#    #+#             */
/*   Updated: 2021/10/21 16:15:47 by nino             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <signal.h>
#include "../../ft_printf/ft_printf.h"

static int	ft_atoi(char const *s)
{
	long int	i;

	i = 0;
	if (*s == '-')
		return (-1);
	while (*s >= '0' && *s <= '9' && i <= 2147483647)
		i = i * 10 + (long int)*s++ - 48;
	if (i > 2147483647)
		return (-1);
	if (!i)
		return (-1);
	return ((int)i);
}

static void	ft_unpause(int sig)
{
	(void)sig;
}

static int	ft_error(int error)
{
	if (error == -1)
		ft_printf ("===================\nWRONG PID !\n===================\n");
	else if (error == 0)
	{
		ft_printf ("=====================\nWRONG ARGS !\n");
		ft_printf ("Usage : ./client [SERVER_PID] [MESSAGE]\n");
		ft_printf ("Exemple : ./client '3065' 'test'\n=====================\n");
	}
	return (-1);
}

int	main(int argc, char **argv)
{
	int	i;
	int	bit;
	int	server_pid;

	i = 0;
	if (argc != 3)
		return (ft_error (0));
	server_pid = ft_atoi(argv[1]);
	signal (SIGUSR1, ft_unpause);
	while (argv[2][i])
	{
		bit = 8;
		while (bit--)
		{
			if ((argv[2][i] >> bit) & 1)
				if (server_pid == -1 || kill (server_pid, SIGUSR2) == -1)
					return (ft_error (-1));
			if (!((argv[2][i] >> bit) & 1))
				if (server_pid == -1 || kill (server_pid, SIGUSR1) == -1)
					return (ft_error (-1));
			pause ();
		}
		i++;
	}
	return (0);
}
