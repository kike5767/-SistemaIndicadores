using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace SistemaIndicadores.API.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Alcance",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Formula",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Meta",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Objetivo",
                table: "Indicadores");

            migrationBuilder.RenameColumn(
                name: "FkIdIndicador",
                table: "CalculoIndicadores",
                newName: "IndicadorId");

            migrationBuilder.AlterColumn<string>(
                name: "Nombre",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: true,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<bool>(
                name: "Activo",
                table: "Usuarios",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Apellido",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<DateTime>(
                name: "FechaCreacion",
                table: "Usuarios",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "PasswordHash",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Role",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "UltimoAcceso",
                table: "Usuarios",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "UserName",
                table: "Usuarios",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "Codigo",
                table: "Indicadores",
                type: "nvarchar(20)",
                maxLength: 20,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(50)",
                oldMaxLength: 50);

            migrationBuilder.AddColumn<bool>(
                name: "Activo",
                table: "Indicadores",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<string>(
                name: "Descripcion",
                table: "Indicadores",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Frecuencia",
                table: "Indicadores",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<string>(
                name: "FuenteDatos",
                table: "Indicadores",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "MetaAnual",
                table: "Indicadores",
                type: "decimal(18,2)",
                nullable: true);

            migrationBuilder.AddColumn<bool>(
                name: "RequiereActualizacion",
                table: "Indicadores",
                type: "bit",
                nullable: false,
                defaultValue: false);

            migrationBuilder.AddColumn<DateTime>(
                name: "UltimaActualizacion",
                table: "Indicadores",
                type: "datetime2",
                nullable: false,
                defaultValue: new DateTime(1, 1, 1, 0, 0, 0, 0, DateTimeKind.Unspecified));

            migrationBuilder.AddColumn<string>(
                name: "UnidadMedida",
                table: "Indicadores",
                type: "nvarchar(max)",
                nullable: true);

            migrationBuilder.AddColumn<int>(
                name: "UsuarioId",
                table: "Indicadores",
                type: "int",
                nullable: true);

            migrationBuilder.AddColumn<decimal>(
                name: "ValorActual",
                table: "Indicadores",
                type: "decimal(18,2)",
                nullable: false,
                defaultValue: 0m);

            migrationBuilder.AlterColumn<string>(
                name: "Nombre",
                table: "Categorias",
                type: "nvarchar(100)",
                maxLength: 100,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(max)");

            migrationBuilder.AddColumn<string>(
                name: "Descripcion",
                table: "Categorias",
                type: "nvarchar(500)",
                maxLength: 500,
                nullable: true);

            migrationBuilder.AlterColumn<double>(
                name: "Resultado",
                table: "CalculoIndicadores",
                type: "float",
                nullable: false,
                oldClrType: typeof(decimal),
                oldType: "decimal(18,2)");

            migrationBuilder.CreateIndex(
                name: "IX_Indicadores_UsuarioId",
                table: "Indicadores",
                column: "UsuarioId");

            migrationBuilder.CreateIndex(
                name: "IX_CalculoIndicadores_IndicadorId",
                table: "CalculoIndicadores",
                column: "IndicadorId");

            migrationBuilder.AddForeignKey(
                name: "FK_CalculoIndicadores_Indicadores_IndicadorId",
                table: "CalculoIndicadores",
                column: "IndicadorId",
                principalTable: "Indicadores",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Indicadores_Usuarios_UsuarioId",
                table: "Indicadores",
                column: "UsuarioId",
                principalTable: "Usuarios",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_CalculoIndicadores_Indicadores_IndicadorId",
                table: "CalculoIndicadores");

            migrationBuilder.DropForeignKey(
                name: "FK_Indicadores_Usuarios_UsuarioId",
                table: "Indicadores");

            migrationBuilder.DropIndex(
                name: "IX_Indicadores_UsuarioId",
                table: "Indicadores");

            migrationBuilder.DropIndex(
                name: "IX_CalculoIndicadores_IndicadorId",
                table: "CalculoIndicadores");

            migrationBuilder.DropColumn(
                name: "Activo",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "Apellido",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "FechaCreacion",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "PasswordHash",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "Role",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "UltimoAcceso",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "UserName",
                table: "Usuarios");

            migrationBuilder.DropColumn(
                name: "Activo",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Descripcion",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Frecuencia",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "FuenteDatos",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "MetaAnual",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "RequiereActualizacion",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "UltimaActualizacion",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "UnidadMedida",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "UsuarioId",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "ValorActual",
                table: "Indicadores");

            migrationBuilder.DropColumn(
                name: "Descripcion",
                table: "Categorias");

            migrationBuilder.RenameColumn(
                name: "IndicadorId",
                table: "CalculoIndicadores",
                newName: "FkIdIndicador");

            migrationBuilder.AlterColumn<string>(
                name: "Nombre",
                table: "Usuarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "",
                oldClrType: typeof(string),
                oldType: "nvarchar(max)",
                oldNullable: true);

            migrationBuilder.AlterColumn<string>(
                name: "Codigo",
                table: "Indicadores",
                type: "nvarchar(50)",
                maxLength: 50,
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(20)",
                oldMaxLength: 20);

            migrationBuilder.AddColumn<string>(
                name: "Alcance",
                table: "Indicadores",
                type: "nvarchar(1000)",
                maxLength: 1000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Formula",
                table: "Indicadores",
                type: "nvarchar(1000)",
                maxLength: 1000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Meta",
                table: "Indicadores",
                type: "nvarchar(1000)",
                maxLength: 1000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<string>(
                name: "Objetivo",
                table: "Indicadores",
                type: "nvarchar(4000)",
                maxLength: 4000,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AlterColumn<string>(
                name: "Nombre",
                table: "Categorias",
                type: "nvarchar(max)",
                nullable: false,
                oldClrType: typeof(string),
                oldType: "nvarchar(100)",
                oldMaxLength: 100);

            migrationBuilder.AlterColumn<decimal>(
                name: "Resultado",
                table: "CalculoIndicadores",
                type: "decimal(18,2)",
                nullable: false,
                oldClrType: typeof(double),
                oldType: "float");
        }
    }
}
