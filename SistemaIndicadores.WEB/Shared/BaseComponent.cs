using Microsoft.AspNetCore.Components;
using MudBlazor;

namespace SistemaIndicadores.WEB.Shared;

public class BaseComponent : ComponentBase
{
    [Inject] protected ISnackbar Snackbar { get; set; } = default!;
    [Inject] protected NavigationManager NavigationManager { get; set; } = default!;

    protected bool IsLoading { get; set; }
    protected string? ErrorMessage { get; set; }

    protected async Task ExecuteAsync(Func<Task> action, string successMessage = "", string errorMessage = "Ha ocurrido un error")
    {
        try
        {
            IsLoading = true;
            ErrorMessage = null;
            await action();

            if (!string.IsNullOrEmpty(successMessage))
            {
                Snackbar.Add(successMessage, Severity.Success);
            }
        }
        catch (Exception ex)
        {
            ErrorMessage = errorMessage;
            Snackbar.Add($"{errorMessage}: {ex.Message}", Severity.Error);
        }
        finally
        {
            IsLoading = false;
            StateHasChanged();
        }
    }

    protected async Task<T> ExecuteAsync<T>(Func<Task<T>> action, string successMessage = "", string errorMessage = "Ha ocurrido un error")
    {
        try
        {
            IsLoading = true;
            ErrorMessage = null;
            var result = await action();

            if (!string.IsNullOrEmpty(successMessage))
            {
                Snackbar.Add(successMessage, Severity.Success);
            }

            return result;
        }
        catch (Exception ex)
        {
            ErrorMessage = errorMessage;
            Snackbar.Add($"{errorMessage}: {ex.Message}", Severity.Error);
            throw;
        }
        finally
        {
            IsLoading = false;
            StateHasChanged();
        }
    }

    protected void ShowError(string message)
    {
        ErrorMessage = message;
        Snackbar.Add(message, Severity.Error);
    }

    protected void ShowSuccess(string message)
    {
        Snackbar.Add(message, Severity.Success);
    }

    protected void ShowWarning(string message)
    {
        Snackbar.Add(message, Severity.Warning);
    }

    protected void ShowInfo(string message)
    {
        Snackbar.Add(message, Severity.Info);
    }
} 