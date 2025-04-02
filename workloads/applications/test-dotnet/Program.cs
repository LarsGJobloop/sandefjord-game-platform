var builder = WebApplication.CreateBuilder(args);

var unrestrictedCors = "UnrestricedCors";
builder.Services.AddCors(options =>
  options.AddPolicy(name: unrestrictedCors, policy => policy
    .WithOrigins("*") // Tells browser from any domains it's okay
    .AllowAnyMethod() // to perform all HTTP methods
    .AllowAnyHeader()) // with any headers
);

var app = builder.Build();

app.UseDefaultFiles(); // Rewrites /index.html -> /
app.UseStaticFiles(); // Serves everything existing in the /wwwroot folder

app.MapPost("/echo", () => new { content = "Echo", timeStamp = DateTime.UtcNow });

app.UseCors(unrestrictedCors);

app.Run();
