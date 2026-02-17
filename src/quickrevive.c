#include "../include/quickrevive.h"

#include <stdio.h>
#include <stdarg.h>
#include <time.h>

#define RED "\x1B[31m"
#define GREEN "\x1B[32m"
#define YELLOW "\x1B[33m"
#define BLUE "\x1B[34m"
#define WHITE "\x1B[37m"
#define RESET "\x1B[0m"

void qlog(qlog_type type, const char* tag, const char* fmt, ...)
{
	char buffer[100];
	printf("%s%s [%s]%s [%s] - ", qtime(buffer, sizeof(buffer)), qcolor(type), qstring(type), RESET, tag);

	va_list args;
	va_start(args, fmt);
	vprintf(fmt, args);
	va_end(args);

	printf("\n");
}

const char* qcolor(qlog_type type)
{
	switch(type)
	{
		case QLOG_ERROR: {
			return RED;
			break;
		}
		case QLOG_INFO: {
			return "";
			break;
		}
		case QLOG_SUCCESS: {
			return GREEN;
			break;
		}
	}
	return "";
}

const char* qstring(qlog_type type)
{
	switch(type)
	{
		case QLOG_ERROR: {
			return "ERROR";
			break;
		}
		case QLOG_INFO: {
			return "INFO";
			break;
		}
		case QLOG_SUCCESS: {
			return "SUCCESS";
			break;
		}
	}
	return "";
}

const char* qtime(char* buffer, size_t bufflen)
{
	time_t now = time(NULL);
	struct tm* t = localtime(&now);

	strftime(buffer, bufflen, "%H:%M:%S", t);
	return buffer;
}
