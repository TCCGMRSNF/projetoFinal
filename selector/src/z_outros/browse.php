<style>
  body {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  }

  h3 {
    color: darkblue;
  }

  table {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
  }

  #t_browse td,
  #t_browse th {
    border: 1px solid #ddd;
    padding: 8px;
  }

  #t_browse tr:nth-child(even) {
    background-color: #f2f2f2;
  }

  #t_browse tr:hover {
    background-color: #ddd;
  }

  #t_browse th {
    padding-top: 12px;
    padding-bottom: 12px;
    text-align: left;
    /*    background-color: #4CAF50;*/
    background-color: cadetblue;
    color: white;
  }

  .btn_link {
    max-width: 20px;
    max-height: 20px;
  }

  .tdiv {
    max-height: 90%;
    overflow-y: scroll;
  }
</style>
<?php echo '<div class="container-fluid bg-info text-center"><strong><em>' . $modulo . '</strong></em></div>'; ?>

<div class="tdiv">
  <table id="t_browse">
    <thead>
      <tr>
        <th class="text-center" style="width: 70px">Ação</th>
        <th class="text-right" style="width: 60px">ID</th>
        <th>Descrição</th>
        <th class="text-right">Tempo (Min)</th>
        <th class="text-center" style="min-width: 200px">Última Edição</th>
      </tr>
    </thead>
    <tbody>
      <?php
      foreach ($tarefas as $tar) {
        echo '
          <tr>
          <td><div class="text-center">
          <a href="' . base_url("tarefas/editar/" . $tar["id"]) . '"><img src="/assets/img/32_editar.png" class="btn_link tooltip-test" title="Editar"></a>
          <a href="javascript:confExc('. $tar["id"] .');"><img src="/assets/img/32_excluir.png" class="btn_link tooltip-test" title="Excluir"></a>
          </div></td>
          <td class="text-right">' . $tar["id"] . '</td>
          <td>' . $tar["descricao"] . '</td>
          <td class="text-right">' . $tar["tempo_p"] . '</td>
          <td class="text-center">' . $tar["ts_edit"] . '</td>
          </tr>';
      }
      ?>
    </tbody>
  </table>
</div>


<script type="text/javascript">
  function confExc(reg) {
    if (confirm('Confirma a exclusão do registro do ID=' + reg))
      window.location.href = "excluir/" + reg;  }
</script>