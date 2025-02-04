var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllers();

// Enged�lyezd a CORS-t
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAll", policy =>
    {
        policy.AllowAnyOrigin()  // Enged�lyez�s minden origin-nek (ha sz�ks�ges, sz�k�theted domain-ra)
              .AllowAnyMethod()  // Enged�lyezett HTTP met�dusok: GET, POST, PUT, DELETE, stb.
              .AllowAnyHeader(); // Enged�lyezett HTTP fejl�cek
    });
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// Enged�lyezd a CORS-t
app.UseCors("AllowAll");

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
