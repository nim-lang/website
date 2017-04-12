.. code-block:: nim

  # Compute average line length
  var
    sum = 0
    count = 0

  for line in stdin.lines:
    sum += line.len
    count += 1

  echo("Average line length: ",
      if count > 0: sum / count else: 0)
