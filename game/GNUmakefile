#
# Quake2 gamei386.so Makefile for Linux
#
# Jan '98 by Zoid <zoid@idsoftware.com>
#
# ELF only
#
# Edited May 11, 2020 by QwazyWabbit
#
# Requires GNU make
#

# this nice line comes from the linux kernel makefile
ARCH := $(shell uname -m | sed -e s/i.86/i386/ -e s/sun4u/sparc64/ -e s/arm.*/arm/ -e s/sa110/arm/ -e s/alpha/axp/)

# On 64-bit OS use the command: setarch i386 make all
# to obtain the 32-bit binary DLL on 64-bit Linux.

CC = gcc

# Required packages for 32-bit builds:
# On x64 machines do this preparation:
# sudo apt-get install ia32-libs
# sudo apt-get install libc6-dev-i386
# On Ubuntu 16.x use sudo apt install libc6-dev-i386
# this will let you build 32-bits on ia64 systems


# This list is preliminary.
# This list is for Debian, other systems vary.
# REQUIRED packages needed to build this project:
# sudo apt install libevent-pthreads
# sudo apt install libcurl4-gnutls-dev
# sudo apt install libmysqlcppconn-dev
# sudo apt install default-libmysqlclient-dev

INCPATH= -I/usr/include -I/usr/include/mysql
LIBINC = -Lpthreads -lm -lmysqlclient -lcurl

# This is for native build
CFLAGS=-O3 -DARCH="$(ARCH)" $(INCPATH)
# This is for 32-bit build on 64-bit host
ifeq ($(ARCH),i386)
CFLAGS =-m32 -O3 -fPIC -DARCH="$(ARCH)" -DSTDC_HEADERS $(INCPATH)
endif

# use this when debugging
#CFLAGS=-g -Og -DDEBUG -DARCH="$(ARCH)" -Wall -pedantic

# flavors of Linux use different libtools
ifeq ($(shell uname),Linux)
LIBTOOL = ldd
endif

# OS X wants to be Linux and FreeBSD too.
ifeq ($(shell uname),Darwin)
LIBTOOL = otool
endif

SHLIBEXT=so
#set position independent code
SHLIBCFLAGS=-fPIC 

ORIGDIR=Source

DO_SHLIB_CC=$(CC) $(CFLAGS) $(SHLIBCFLAGS) -o $@ -c $<

.c.o:
	$(DO_SHLIB_CC)

#############################################################################
# SETUP AND BUILD
# GAME
#############################################################################

GAME_OBJS = \
g_ai.o g_chase.o g_cmds.o g_combat.o g_func.o g_items.o g_main.o g_misc.o \
g_monster.o g_phys.o g_save.o g_spawn.o g_svcmds.o g_target.o g_trigger.o \
g_turret.o g_utils.o g_weapon.o kots_abilities.o kots_admin.o kots_array.o \
kots_bfg.o kots_character.o kots_commands.o kots_configstrings.o \
kots_conpersist.o kots_cvars.o kots_dbthread.o kots_hook.o kots_hud.o \
kots_items.o kots_linkedlist.o kots_logging.o kots_maplist.o kots_menu.o \
kots_monster.o kots_motd.o kots_mute.o kots_mysql_helper.o kots_pickups.o \
kots_player.o kots_power.o kots_pweapon.o kots_resist.o kots_runes.o \
kots_sabre.o kots_server.o kots_svcmds.o kots_tballs.o kots_update.o \
kots_utils.o kots_weapondamage.o kots_weapon.o \
m_actor.o m_berserk.o m_boss2.o m_boss31.o m_boss32.o m_boss3.o m_brain.o \
m_chick.o m_flash.o m_flipper.o m_float.o m_flyer.o m_gladiator.o \
m_gunner.o m_hover.o m_infantry.o m_insane.o m_medic.o m_move.o m_mutant.o \
m_parasite.o m_soldier.o m_supertank.o m_tank.o p_client.o p_hud.o \
p_menu.o p_trail.o p_view.o p_weapon.o q_shared.o


game$(ARCH).real.$(SHLIBEXT) : $(GAME_OBJS)
	$(CC) $(CFLAGS) -shared -o $@ $(GAME_OBJS) -ldl -lm $(LIBINC)
	$(LIBTOOL) -r $@


#############################################################################
# MISC
#############################################################################

clean:
	/bin/rm -f $(GAME_OBJS) game$(ARCH).real.$(SHLIBEXT)

depend:
	$(CC) -MM $(GAME_OBJS:.o=.c)

depends:
	$(CC) $(CFLAGS) -MM *.c > dependencies

all:
	make clean
	make depends
	make

-include dependencies

