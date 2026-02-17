#include "../include/quickrevive.h"

int main()
{
	int port = 8080;

	qlog(QLOG_SUCCESS, "APP", "Application started");
	qlog(QLOG_INFO, "NETWORK", "Connecting on port %d", port);
	qlog(QLOG_ERROR, "USER", "Failed to create user");

	return 0;
}
