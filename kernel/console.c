#include <carl/commands.h>
#include <carl/video.h>
#include <carl/keyboard.h>
#include <ckernel.h>
#include <carl/memory.h>
#include <carl/error.h>

#define COMMAND_SIZE 256

static char command[COMMAND_SIZE];
static unsigned int command_pos = 0;

static void terminal_prompt(void)
{
    c_vsetcolor(C_GREEN);
    c_vputs("C:\\> ");
}

static void terminal_execute(void)
{
    command[command_pos] = '\0';

    if (command_pos == 0)
    return;

    if(c_memcmp(command, "dir", 4) == 0)
    {
        c_dir();
    }
    else if(c_memcmp(command, "cd", 3) == 0)
    {
        c_cd(&command[3]);
    }
    else if(c_memcmp(command, "mkdir", 6) == 0)
    {
        c_mkdir(&command[6]);
    }
    else if(c_memcmp(command, "copy", 5) == 0)
    {
        c_vsetcolor(C_YELLOW);
        c_vputs("copy: implementacao pendente\r\n");
    }
    else if(c_memcmp(command, "del", 4) == 0)
    {
        c_vsetcolor(C_YELLOW);
        c_vputs("del: implementacao pendente\r\n");
    }
    else
    {
        c_vsetcolor(C_RED);
        c_vputs("Carl: command not found\r\n");
    }

    command_pos = 0;

}

void run_kernel(void)
{
    c_vinit();
    c_vclear();

    c_kinit();

    c_vsetcolor(C_LIGHT_GREEN);
    c_vputs("Welcome to new OS, Carl.\r\n");
    c_vputs("Carl 0.1.\r\n");
    c_vputs("\r\n");

    c_memset(command 0, COMMAND_SIZE);

    terminal_prompt();

    while(1)
    {
        char c = c_kgetchar();

        if (c == '\r' || c == '\n')
        {
            c_vputs("\r\n");

            terminal_execute();

            terminal_prompt();
        }
        else if (c == '\b')
        {
            if (command_pos > 0)
            {
                command_pos--;

                command[command_pos] = 0;

                c_vputs("\b\b");
            }
        }
        else if (command_pos < COMMAND_SIZE - 1)
        {
            command[command_pos++] = c;

            c_vsetcolor(C_GREEN);

            c_vputchar(c);
        }
    }
}
