# Development environment configuration

Please ensure your machine conforms to these prerequisites:

- A modern laptop running Windows 10, Mac OSX 10.12 or higher, or a recent version of Linux.

- Your preferred IDE (integrated development environment) for exploring the Contoso Video web app or data generator projects, such as [Visual Studio Code](https://code.visualstudio.com/) or [Visual Studio](https://visualstudio.microsoft.com/).

**If** you wish to run the web app or data generator locally **from the source**, you will need to install the following:

- [Download .NET Core 3.x SDK](https://dotnet.microsoft.com/download/dotnet-core/3.0) for your platform.
- [Download .NET Framework 4.7.2](https://dotnet.microsoft.com/download/dotnet-framework/net472) for the web app if using Windows.

## Set up data generator

We have provided a data generator that simulates user clickstream data and pumps it into Azure Event Hubs. You will use this generator in some of the challenges, but it is a good idea to configure it beforehand. The data generator is deployed as a .NET Core 3.0 self-contained deployment (SCD) package. This means that the .NET Core runtime is included within each platform folder, so you do not need to download the .NET Core 3.0 SDK as a pre-requisite.

1. [Download the zip file](https://openhackguides.blob.core.windows.net/no-sql-artifacts/DataGenerator.zip) and extract it to your desktop.

2. Open the folder containing the extracted files, then open either the `linux-x64`, `osx-x64`, or `win-x64` subfolder, based on your environment.

3. Within the appropriate subfolder, open the **appsettings.json** file and update it with the following:

   - **EVENT_HUB_1_CONNECTION_STRING**: Open the Event Hubs namespace in the location 1 resource group (default name is `openhack1`), open the `telemetry` event hub, create a new shared access policy with a Send policy, and paste its connection string here.
   - **EVENT_HUB_2_CONNECTION_STRING**: Keep empty for now. This will need to be populated in a later challenge.
   - **SQL_CONNECTION_STRING**: The easiest way to retrieve this is to open the web app deployed to the location 1 resource group (`openhack1`), open **Configuration**, then copy the `SqlConnection` connection string value.

## How to execute the data generator

When you need to execute the data generator, perform the following, based on your platform:

1. Windows:

   - Simply execute **DataGenerator.exe** inside the `win-x64` folder.

2. Linux:

   - Navigate to the `linux-x64` folder.
   - Run `chmod 777 DataGenerator` to provide access to the binary.
   - Run `./DataGenerator`.

3. MacOS:

   - Open a new terminal.
   - Navigate to the `osx-x64` directory.
   - Run `./DataGenerator`.
