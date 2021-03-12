CREATE TABLE bricks (brick_id  INTEGER
, colour    VARCHAR2 (10)
, shape     VARCHAR2 (10)
, weight    INTEGER);

INSERT INTO bricks VALUES (1, 'blue', 'cube', 1);
INSERT INTO bricks VALUES (2, 'blue', 'pyramid', 2);
INSERT INTO bricks VALUES (3, 'red', 'cube', 1);
INSERT INTO bricks VALUES (4, 'red', 'cube', 2);
INSERT INTO bricks VALUES (5, 'red', 'pyramid', 3);
INSERT INTO bricks VALUES (6, 'green', 'pyramid', 1);

COMMIT;

SELECT b.*
     , COUNT (*)
         OVER ()                       AS total
     , COUNT (*)
         OVER (PARTITION BY colour)    AS total_colour
     , SUM (weight)
         OVER (PARTITION BY colour)    AS sum_weigth_colour
     , SUM (weight)
         OVER (PARTITION BY colour
               ORDER BY colour
                      , weight)                     AS sum_weight_colour_acumulate
FROM bricks b;

SELECT b.*
     , SUM (weight)
         OVER (
ORDER BY weight ROWS UNBOUNDED PRECEDING)
FROM bricks b
ORDER BY weight;