This folder contains:

--- the matlab codes of the Real-time Change Point Detector (RCPD2). RCPD2 is a mean CP detector that builds upon our previous introduced RCPD detector, published in [1] 

============================ Matlab codes =======================================

----> For a demo please launch the following scripts:

-1- LN.m contains an execution of RCPD2 algorithm across time-series generated through Log-Normal distribution, assuming several LN parameters.

-2- armagarch.m contains an execution of RCPD2 of RCPD2 algorithm over ARMA-GARCH generated time-series, assuming several ARMA-GARCH parameters.

----> For a demo over real-world time-series please launch the following scripts:

-1- delay_wl.xlsx: excel file  that provides the delay values (in msec) of 27 links (over 10 nodes)  from the W.iLab.1 FED4FIRE+ testbed. Each column provides the delay measurements of each different link; the first two rows of each column present the nodes for which each link is described. 

-2- plr_wl.xlsx: excel file  that provides the PLR values (in msec) of 27 links (over 10 nodes)  from the W.iLab.1 FED4FIRE+ testbed. Each column provides the delay measurements of each different link; the first two rows of each column present the nodes for which each link is described.

-3- cpSigr.m contains an execution of RCPD2 over the real measurements.

[1] Skaperas, Sotiris, Lefteris Mamatas, and Arsenia Chorti. "Real-time video content popularity detection based on mean change point analysis." IEEE Access, vol. 7, 2019.
