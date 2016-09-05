Structure
---------

Each directory corresponds to a race.
For example, `0` is human, `1` is dwarf, etc.
For a full list, see [`src/p3600/race.lua`](../../../../src/p3600/race.lua)

Here is what the directories mean:

| Directory           | Description                                                                                  |
|:------------------- |:-------------------------------------------------------------------------------------------- |
| `/body`             | All the different bodies for procedurally generated creatures. (naked, clothes are seperate) |
| `/body/0`           | &emsp;Unsexed variations                                                                     |
| `/body/0/0.tga`     | &emsp;&emsp;Unsexed variant 1                                                                |
| `/body/0/1.tga`     | &emsp;&emsp;Unsexed variant 2                                                                |
| `/body/0/2.tga`     | &emsp;&emsp;Unsexed variant 3                                                                |
|                     | &emsp;&emsp;(you get the idea) (no limit to number of variants, must be at least one)        |
| `/body/1`           | &emsp;Male variations                                                                        |
| `/body/2`           | &emsp;Female variations                                                                      |
| `/body/3`           | &emsp;Hermaphrodite variations                                                               |
| `/equip`            | All of the equipment sprites. They are drawn over the body, but under the hair.              |
| `/equip/(ID)`       | &emsp;An item.                                                                               |
| `/equip/(ID)/0.tga` | &emsp;&emsp;Unsexed version.                                                                 |
| `/equip/(ID)/1.tga` | &emsp;&emsp;Male version.                                                                    |
| `/equip/(ID)/2.tga` | &emsp;&emsp;Female version.                                                                  |
| `/equip/(ID)/3.tga` | &emsp;&emsp;Hermaphrodite version.                                                           |
| `/hair`             | All the different hairstyles for procedurally generated creatures. Drawn over everything.    |
| `/hair/0`           | &emsp;Unsexed variations (same as for `/body`)                                               |
| `/hair/1`           | &emsp;Male variations                                                                        |
| `/hair/2`           | &emsp;Female variations                                                                      |
| `/hair/3`           | &emsp;Hermaphrodite variations                                                               |
| `/p`                | Default player skin for the race. (also naked, clothes are seperate)                         |
| `/p/0`              | &emsp;Unsexed                                                                                |
| `/p/0/body.tga`     | &emsp;&emsp;Unsexed body (same for 1, 2, and 3)                                              |
| `/p/0/hair.tga`     | &emsp;&emsp;Unsexed hair (same for 1, 2, and 3)                                              |
| `/p/1`              | &emsp;Male                                                                                   |
| `/p/2`              | &emsp;Female                                                                                 |
| `/p/3`              | &emsp;Hermaphrodite                                                                          |
