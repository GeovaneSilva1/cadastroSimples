program ProjetoTreinamento;

uses
  Forms,
  uTreinamento in 'uTreinamento.pas' {frmPrincipal},
  uConsulta in 'uConsulta.pas' {frmConsulta},
  uFiltro in 'uFiltro.pas' {frmFiltros},
  uProcedimentosPadroes in 'uProcedimentosPadroes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TfrmFiltros, frmFiltros);
  Application.Run;
end.
