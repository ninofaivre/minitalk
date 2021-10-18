/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: nino <nino@student.42.fr>                  +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/09/08 13:20:25 by nino              #+#    #+#             */
/*   Updated: 2021/09/15 11:07:51 by nino             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <signal.h>
#include "../../ft_printf/ft_printf.h"

static void	handler(int sig, siginfo_t *info, void *context)
{
	static char	c = 0;
	static int	count = 0;
	int			client_pid;

	(void)context;
	client_pid = info->si_pid;
	if (sig == SIGUSR1)
		c = (c << 1);
	else if (sig == SIGUSR2)
		c = (c << 1) | 1;
	if (++count == 8)
	{
		count = 0;
		ft_printf ("%c", c);
		c = 0;
	}
	usleep(300);
	kill (client_pid, SIGUSR1);
}

int	main(void)
{
	struct sigaction	sa;

	ft_printf ("PID : %i\n", getpid());
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = handler;
	while (1)
	{
		sigaction(SIGUSR1, &sa, NULL);
		sigaction(SIGUSR2, &sa, NULL);
		pause ();
	}
}
