#include "topmodel.h"

void topidx_calc(double *topidx, int nidxclass)
{
	int	i, j;
	double	x;

	idxstats.atb = (double *) R_Calloc(nidxclass, double);
	idxstats.Aatb_r = (double *) R_Calloc(nidxclass, double);

	for(i=0; i<nidxclass; i++) {
		idxstats.atb[i] = topidx[i];
		idxstats.Aatb_r[i] = topidx[i+nidxclass];
	}

/* sort index classes from high to low */

	for(i=0; i<nidxclass; i++){
		for(j=i; j<nidxclass; j++){
			if(idxstats.atb[i] < idxstats.atb[j]){
				x = idxstats.atb[i];
				idxstats.atb[i] = idxstats.atb[j];
				idxstats.atb[j] = x;
				x = idxstats.Aatb_r[i];
				idxstats.Aatb_r[i] = idxstats.Aatb_r[j];
				idxstats.Aatb_r[j] = x;
			}
		}
	}

	return;
}


void memory_allocation(int nch, int ntimestep, int nidxclass)
{
	int i;

	misc.Qt = (double *) R_Calloc(ntimestep, double);
	misc.S_mean = (double *) R_Calloc(ntimestep, double);

	params.d = (double *) R_Calloc(nch, double);
	params.Ad_r = (double *) R_Calloc(nch, double);

	misc.Srz = (double **) R_Calloc(ntimestep, double *); /* Root zone storage deficit */
	misc.Suz = (double **) R_Calloc(ntimestep, double *); /* Unsaturated zone storage */

	misc.S = (double **) R_Calloc(ntimestep, double *);
	misc.Ea = (double **) R_Calloc(ntimestep, double *);
	misc.ex = (double **) R_Calloc(ntimestep, double *);

	misc.qt = (double **) R_Calloc(ntimestep, double *);
	misc.qo = (double **) R_Calloc(ntimestep, double *);
	misc.qv = (double **) R_Calloc(ntimestep, double *);
	misc.qint = (double **) R_Calloc(ntimestep, double *);

	misc.qs = (double *) R_Calloc(ntimestep, double);
	misc.f = (double *) R_Calloc(ntimestep, double);
	misc.fex = (double *) R_Calloc(ntimestep, double);

	for(i=0; i<ntimestep; i++){
		misc.Srz[i] = (double *) R_Calloc(nidxclass, double);
		misc.Suz[i] = (double *) R_Calloc(nidxclass, double);

		misc.S[i]  = (double *) R_Calloc(nidxclass, double);
		misc.Ea[i] = (double *) R_Calloc((nidxclass + 1), double);
		misc.ex[i] = (double *) R_Calloc((nidxclass + 1), double);

		misc.qt[i] = (double *) R_Calloc((nidxclass + 1), double);
		misc.qo[i] = (double *) R_Calloc((nidxclass + 1), double);
		misc.qv[i] = (double *) R_Calloc((nidxclass + 1), double);
		misc.qint[i] = (double *) R_Calloc((nidxclass + 1), double);
	}

	return;
}

void memory_free(int nch, int ntimestep, int nidxclass)
{
	int i;

	for(i=0; i<ntimestep; i++){
		R_Free(misc.Srz[i]);
		R_Free(misc.Suz[i]);

		R_Free(misc.S[i]);
		R_Free(misc.Ea[i]);
		R_Free(misc.ex[i]);

		R_Free(misc.qt[i]);
		R_Free(misc.qo[i]);
		R_Free(misc.qv[i]);
		R_Free(misc.qint[i]);
	}

	R_Free(misc.Qt);
	R_Free(misc.S_mean);

	R_Free(params.d);
	R_Free(params.Ad_r);

	R_Free(misc.Srz);
	R_Free(misc.Suz);

	R_Free(misc.S);
	R_Free(misc.Ea);
	R_Free(misc.ex);

	R_Free(misc.qt);
	R_Free(misc.qo);
	R_Free(misc.qv);
	R_Free(misc.qint);

	R_Free(misc.qs);
	R_Free(misc.f);
	R_Free(misc.fex);

	R_Free(idxstats.atb);
	R_Free(idxstats.Aatb_r);

/* a few missing! */

	return;
}
