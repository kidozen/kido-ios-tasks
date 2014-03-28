kido-ios-tasks
==============

Sample task application

In the file AppDeletage.m update the following constants value using your credentials

	#define TENANT  @"https://marketplace.kidocloud.com"
	#define APP     @"tasks"
	#define USER    @"your user @kidozen.com"
	#define PASS    @"your secret"

Code Details
============

The AppDelegate class has a public KZApplication property (kidozenApplication).

In the ViewControllers classes access this property to interact with KidoZen services. For example to create an instance of the 'tasks' storage collection use the following line of code:

	[[taskApplicationDelegate kidozenApplication] StorageWithName:@"tasks"];


#License 

Copyright (c) 2013 KidoZen, inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE 