/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ft_echo.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gpetrov <gpetrov@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2014/03/25 22:40:04 by gpetrov           #+#    #+#             */
/*   Updated: 2014/03/27 21:33:22 by ymohl-cl         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdlib.h>
#include "ft_minishell.h"
#include "header.h"
#include "libft.h"

int		ft_echo_check_env2(char **env, char *val)
{
	int		i;
	int		j;
	char	*tmp;

	j = -1;
	i = -1;
	tmp = (char *)malloc(sizeof(char) * ft_strlen(val));
	while (val[++j] != 0)
		tmp[j] = ((val[j] >= 'A' || val[j] <= 'Z') ? (val[j] - 32) : val[j]);
	tmp[j] = 0;
	while (env[++i] != 0)
	{
		if (ft_strncmp(env[i], tmp, (size_t)ft_strlen(tmp)) == 0)
		{
			ft_echo_value(env[i]);
			free(tmp);
			return (1);
		}
	}
	free(tmp);
	return (0);
}

int		ft_echo_check_env(char **env, char *val)
{
	int		i;
	int		j;

	i = -1;
	j = -1;
	while (env[++i] != 0)
	{
		if (ft_strncmp(env[i], val, (size_t)ft_strlen(val)) == 0)
		{
			ft_echo_value(env[i]);
			return (1);
		}
	}
	return (-1);
}

void	ft_echo_help_norm(int *k, int *j)
{
	*k = 0;
	*j = 0;
}

int		ft_echo_help(char *arg, char **env)
{
	int		j;
	int		k;
	char	*tmp;

	ft_echo_help_norm(&k, &j);
	tmp = (char *)malloc(sizeof(char) * (ft_strlen(arg) + 1));
	while (arg[++k] != 0)
		tmp[j++] = arg[k];
	tmp[j] = 0;
	if (ft_echo_check_env(env, tmp) == -1)
	{
		ft_putstr(tmp);
		ft_putstr(": Undefined variable.");
		free(tmp);
		return (-1);
	}
	free(tmp);
	return (0);
}

int		ft_echo(char **arg, char **env)
{
	int		mark;
	int		i;
	int		offset;

	mark = 0;
	i = 0;
	offset = 1;
	if (arg[1] && arg[1][0] && arg[1][1] &&
		arg[1][0] == '-' && arg[1][1] == 'n' && (i = 1))
		mark = 1;
	while (arg[++i])
	{
		if (offset == 0)
			ft_putchar(' ');
		offset = 0;
		if (arg[i] && arg[i][0] && arg[i][0] == '$')
			ft_echo_help(arg[i], env);
		else
			ft_putstr(arg[i]);
	}
	if (mark == 0)
		ft_putchar('\n');
	return (0);
}
