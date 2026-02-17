#ifndef QUICKREVIVE_H
#define QUICKREVIVE_H

#include <stddef.h>

typedef enum
{
	QLOG_ERROR,
	QLOG_SUCCESS,
	QLOG_INFO
} qlog_type;

void qlog(qlog_type type, const char* tag, const char* fmt, ...);
const char* qcolor(qlog_type type);
const char* qstring(qlog_type type);
const char* qtime(char* buffer, size_t bufflen);

#endif
