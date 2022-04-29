using PuppeteerSharp;

using (var browser = await Puppeteer.LaunchAsync(new LaunchOptions
{
    Headless = true,
    Args = new[]
    {
        "--no-sandbox"
    }
}))
using (var page = await browser.NewPageAsync())
{
    await page.GoToAsync("https://www.squidex.io");

    Console.WriteLine(await page.QuerySelectorAsync(".welcome-title").EvaluateFunctionAsync<string>("el => el.innerText"));
}