namespace cs;

public class Program
{
    private static readonly HttpClient HttpClient = new();

    public static async Task Main(string[] args)
    {
        var builder = WebApplication.CreateSlimBuilder(args);
        var app = builder.Build();
        var waitingServerUrl = Environment.GetEnvironmentVariable("WAITINGSERVER_URL")
                               ?? "http://localhost:8000";
        var runningPort = Environment.GetEnvironmentVariable("RUNNING_PORT")
                          ?? "8080";

        app.MapGet("", async () =>
        {
            var response = await HttpClient.GetAsync(waitingServerUrl);
            var result = await response.Content.ReadAsStringAsync();

            return result;
        });

        Console.WriteLine($"Listening on: http://localhost:{runningPort}");
        await app.RunAsync();
    }
}