# P-Rank+: A Scalable Efficient P-Rank Search Algorithm

## Environment:
-Ubuntu 20.04 LTS \
-Intel® Xeon® Gold 6226R CPU @ 2.9GHz $\times$ 64 and 256GB RAM \
-Matlab R2020a

## Main
(1)**Time** \
cd **P_Rank_Time**/ run P_Rank_Main.m:
>> 1. These codes in **P_Rank_Time** folder test the computation time on real datasets.

(2) **Memory**\
cd **P_Rank_Memory**/ run P_Rank_Main_Mem.m:
>> 1. In **P_Rank_Memory** folder, we provide these codes to test the memory usage on real datasets.

(3) **Accuracy**\
cd **P_Rank_Acc**/  run P_Rank_Main_Acc.m:
>> 1. In **P_Rank_Acc** folder,  we test the impact of different paraments $r$ on the accuracy of PR+ and PR-NI on real datasets. 

## Compared Algorithms:
PR+：    Our algorithm;\
PR-NI：  the best-known matrix-based approach;\
PR-IT：  the naive fixed-point iterative P-Rank method.\

## Datasets:
We use real-life datasets publicly available on SNAP：http://snap.stanford.edu/data/

ca-GrQc  (CA)：           Arxiv Collaboration network\
p2p-Gnutella25 (P2P)：    Gnutella peer-to-peer network\
EuAll(EA):                EU email contact graph\
com-Youtube (YT)：        Youtube social network communities\
Arabic (AB)：             Web crawl of Arabic domains\
twitter7(TW):             Twitter user-follower network\
webbase-2001(WB):          A graph obtained by a Webbase crawler    
