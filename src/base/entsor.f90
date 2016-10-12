!-------------------------------------------------------------------------------

! This file is part of Code_Saturne, a general-purpose CFD tool.
!
! Copyright (C) 1998-2016 EDF S.A.
!
! This program is free software; you can redistribute it and/or modify it under
! the terms of the GNU General Public License as published by the Free Software
! Foundation; either version 2 of the License, or (at your option) any later
! version.
!
! This program is distributed in the hope that it will be useful, but WITHOUT
! ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
! FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
! details.
!
! You should have received a copy of the GNU General Public License along with
! this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
! Street, Fifth Floor, Boston, MA 02110-1301, USA.

!-------------------------------------------------------------------------------

!> \file entsor.f90
!> \brief Module for input/output

module entsor

  !=============================================================================
  use, intrinsic :: iso_c_binding
  use paramx

  implicit none

  !=============================================================================

  !> \defgroup entsor Module for input/output

  !> \addtogroup entsor
  !> \{

  !> standard output
  integer, save :: nfecra

  !> unit of the upstream restart file for the vortex method.
  !> Useful if and only if \ref optcal::isuivo "isuivo"=1 and
  !> \ref optcal::ivrtex "ivrtex"=1.
  integer, save :: impmvo

  !> unit of the downstream restart file for the vortex method.
  !> Useful if and only if \ref optcal::ivrtex "ivrtex"=1.
  integer, save :: impvvo

  !> unit of the \ref vorinc::ficvor "ficvor" data files for the vortex method.
  !>
  !> These files are text files. Their number and names are specified by the user
  !> in the \ref usvort subroutine.
  !> (Although it corresponds to an 'upstream' data file, \ref impdvo is
  !> initialized to 20 because, in case of multiple vortex entries,
  !> it is opened at the same time as the upstream restart file,
  !> which already uses unit 11)
  !> useful if and only if \ref optcal::ivrtex "ivrtex"=1.
  integer, save :: impdvo

  !> name of file, see usvort module.
  character(len=13), save :: ficdat

  !> saving period of the restart filesy5
  !>   - -2: no restart at all
  !>   - -1: only at the end of the calculation
  !>   - 0: by default (four times during the calculation)
  !>   - \>0: period
  integer, save :: ntsuit

  !> field key for output label
  integer, save :: keylbl = -1

  !> field key for logging \n
  !> For every quantity (variable, physical or numerical property ...),
  !> indicator concerning the writing in the execution report file
  !>    - 1: writing in the execution listing.
  !>    - 0: no writing.
  !> always useful
  integer, save :: keylog = -1

  !> <a name="keyvis"></a>
  !> field key for postprocessing output.
  !>
  !> Each quantity defined at the cell centres (physical or
  !> numerical variable), indicator of whether it should be
  !> post-processed or not
  !>   - -999: not initialised. By default, the post-processed quantities are the
  !> unknowns (pressure, velocity, \f$ k, \epsilon, Rij, \omega, \phi, f \f$k, scalars),
  !> density, turbulent viscosity and the time step if is not uniform
  !>   - 0: not post-processed
  !>   - 1: post-processed on main location
  !>   - 2: non-reconstructed values postprocessed on boundary if main location is cells
  !>   - 3: both 1 and 2
  !> useful if and only if the variable is defined at the cell centers or boundary faces:
  !> calculation variable, physical property (time step, density, viscosity, specific heat) or
  !> turbulent viscosity if \ref iturb = 10
  integer, save :: keyvis = -1

  !> \}

  !> \defgroup userfile Additional user files

  !> \addtogroup userfile
  !> \{

  !> name of the thermochemical data file.
  !>
  !> The launch script is designed
  !> to copy the user specified thermochemical data file in the temporary
  !> execution directory under the name \em dp_thch, for \e Code_Saturne to open
  !> it properly.  Should the value of \ref ficfpp be changed, the launch script
  !> would have to be adapted.
  !> Useful in case of gas or pulverised coal combustion.
  character(len=32), save :: ficfpp

  !> logical unit of the thermochemical data file.
  !> Useful in case of gas or pulverised coal combustion or electric arcs;
  integer, save :: impfpp

  !> perform Janaf (=1) or not (=0)
  integer, save :: indjon

  !> Input files for the atmospheric specific physics
  !> (name of the meteo profile file)
  character(len=32), save :: ficmet
  !> logical unit of the meteo profile file
  integer, save :: impmet

  !> \}

  !> \defgroup history History user files

  !> \addtogroup history
  !> \{

  !> Maximum number of user chronological files.
  !> In the case where \ref ushist is used.
  integer    nushmx
  parameter(nushmx=16)

  !> directory in which the potential chronological record files generated by
  !> the Kernel will be written (path related to the execution directory)
  !> - it is recommended to keep the default value and, if necessary, to modify
  !> the launch script to copy the files in the alternate destination directory
  !> - useful if and only if chronological record files are generated
  character(len=80), save :: emphis

  !> prefix of history files
  character(len=80), save :: prehis

  !> units of the user chronological record files.
  !> Useful if and only if the subroutine \ref ushist is used.
  integer, save :: impush(nushmx)

  !> names of the user chronological record files.
  !>
  !> In the case of a non-parallel
  !> calculation, the suffix applied the file name is a three digit number:
  !> \f$ \texttt{ush001}\f$, \f$\texttt{ush002}\f$, \f$\texttt{ush003}\f$...
  !> In the case of a parallel-running calculation,
  !> the four digit processor index-number is added to the suffix.
  !> For instance, for a calculation running on two processors:
  !>  -from \f$ \texttt{ush001.n\_0001} \f$ to  \f$ \texttt{ush010.n\_0001} \f$
  !>  -and \f$ \texttt{ush001.n\_0002} \f$ to \f$ \texttt{ush010.n\_0002} \f$.
  !>  - ush001.n_0002, ush002.n_0002, ush003.n_0002...
  !> The opening, closing, format and location of these files must be managed
  !> by the user. Useful if and only if the subroutine \ref ushist is used
  character(len=13), save :: ficush(nushmx)

  !> stock file and mobile structure variables output unit
  integer, save :: impsth(2)

  !> maximum number of probes
  !> see associated format in \ref ecrhis
  integer    ncaptm
  parameter(ncaptm=200)

  !> time plot format (1: .dat, 2: .csv, 3: both)
  integer, save :: tplfmt

  !> total number of probes (limited to \ref ncaptm=200)
  integer, save :: ncapt

  !> output period of the chronological record files:
  !> - -1: no output
  !> - \>0: period  (every \ref nthist time step)
  !>
  !> The default value is -1 if there is no chronological record file to
  !> generate (if there is no probe, or no active probe output) and 1 otherwise.
  !> If chronological records are generated, it is usually wise to keep the
  !> default value \ref nthist=1, in order to avoid missing any high frequency
  !> evolution (unless the total number of time steps is much too big).
  !> Useful if and only if chronological record files are generated
  integer, save :: nthist

  !> frhist : output frequency in seconds
  double precision, save :: frhist

  !> write indicator (O or 1) for history of internal mobile structures
  integer, save :: ihistr

  !> probes corresponding element
  integer, save :: nodcap(ncaptm)

  !> row of process containing nodcap (in parallel processing)
  integer, save :: ndrcap(ncaptm)

  !> required position for a probe
  !> 3D-coordinates of the probes.
  !> the coordinates are written: \ref xyzcap "xyzcap"(i,j), with i = 1,2 or 3
  !> and j <= \ref ncapt.
  !> Useful if and only if \ref ncapt > 0.
  double precision, save :: xyzcap(3,ncaptm)

  !> \}

  !> \addtogroup userfile
  !> \{

  ! --- Fichiers utilisateurs

  !> maximal number of user files
  integer    nusrmx
  parameter(nusrmx=20)

  !> unit numbers for potential user specified files.
  !> Useful if and only if the user needs files
  !> (therefore always useful, by security)
  integer, save ::      impusr(nusrmx)

  !> name of the potential user specified files.
  !>
  !> In the case of a non-parallel
  !> calculation, the suffix applied the file name is a two digit number:
  !> from \f$ \texttt{usrf01} \f$ to \f$ \texttt{usrf10} \f$ .
  !> In the case of a parallel-running calculation, the four digit processor index-number is
  !> added to the suffix. For instance, for a calculation running on two
  !> processors: from \f$ \texttt{usrf01.n\_0001} \f$ to  \f$ \texttt{usrf10.n\_0001} \f$ and
  !> from \f$ \texttt{usrf01.n\_0002} \f$ to \f$ \texttt{usrf10.n\_0002} \f$ . The opening,
  !> closing, format and location of these files must be managed by the user.
  !> useful if and only if the user needs files (therefore always useful, by security)
  character(len=13), save :: ficusr(nusrmx)

  !> \}

  !> \defgroup listing Output listing

  !> \addtogroup listing
  !> \{

  !> temporary variable name for some algebraic operations
  character(len=80), save :: nomva0

  !> locator pointer for variables output
  integer, save :: ippdt
  !> locator pointer for variables output
  integer, save :: ipptx
  !> locator pointer for variables output
  integer, save :: ippty
  !> locator pointer for variables output
  integer, save :: ipptz

  !> writing period in the execution report file.
  !>   - -1: no writing
  !>   - \> 0: period (every \ref ntlist time step). The value of
  !> \ref ntlist must be adapted according to the number of iterations
  !> carried out in the calculation. Keeping \ref ntlist to 1 will indeed provide
  !> a maximum volume of information, but if the number of time steps
  !> is too large the execution report file might become too big and unusable
  !> (problems with disk space, memory problems while opening the file with a
  !> text editor, problems finding the desired information in the file, ...).
  integer(c_int), pointer, save :: ntlist

  !> \defgroup other_output Boundary post-processing

  !> \addtogroup other_output
  !> \{

  !> indicates the data to post-process on the boundary mesh (the boundary mesh
  !> must be associated with an active writer). \ref ipstdv "ipstdv"(key)
  !> indicates which fields should be created and output on the boundary,
  !> with \c key in \ref ipstfo, \ref ipstyp, \ref ipsttp, \ref ipstft,
  !> \ref ipstnu.
  integer, save :: ipstdv(5)

  !> post-processed property: Efforts (0: none 1: all; 2: tangent; 4: normal)
  integer    ipstfo
  !> post-processed property: \f$ y^+ \f$ at the boundary
  integer    ipstyp
  !> post-processed property :\f$ T^+ \f$ at the boundary
  integer    ipsttp
  !> post-processed property: thermal flux at the boundary
  !>(in  \f$ W\,m^{-2} \f$),
  integer    ipstft
  !> post-processed property: Nusselt
  integer    ipstnu
  parameter (ipstfo=1, ipstyp=2, ipsttp= 3, ipstft=4, ipstnu=5)

  !> margin in seconds on the remaining CPU time which is necessary to allow
  !> the calculation to stop automatically and write all the required results
  !> (for the machines having a queue manager).
  !>   - -1: calculated automatically,
  !>   - 0: margin defined by the user.
  !> Always useful, but the default value should not be changed.
  double precision, save :: tmarus
  !> \}
  !> \}

  !=============================================================================

  interface

    !---------------------------------------------------------------------------

    !> \cond DOXYGEN_SHOULD_SKIP_THIS

    !---------------------------------------------------------------------------

    ! Interface to C function retrieving pointers of ntlist

    subroutine cs_f_log_frequency_get_pointer(ntlist)             &
      bind(C, name='cs_f_log_frequency_get_pointer')
      use, intrinsic :: iso_c_binding
      implicit none
      type(c_ptr), intent(out) :: ntlist
    end subroutine cs_f_log_frequency_get_pointer

    !---------------------------------------------------------------------------

    !> (DOXYGEN_SHOULD_SKIP_THIS) \endcond

    !---------------------------------------------------------------------------

  end interface

  !=============================================================================

contains

  !=============================================================================

  !> \brief Flush Fortran log

  subroutine flush_nfecra() bind(C, name='cs_f_flush_logs')
    flush(nfecra)
  end subroutine flush_nfecra

  !=============================================================================

  !> \brief Map ntlist from C to Fortran

  subroutine listing_writing_period_init

    use, intrinsic :: iso_c_binding
    implicit none

    ! Local variables

    type(c_ptr) :: c_ntlist

    call cs_f_log_frequency_get_pointer(c_ntlist)

    call c_f_pointer(c_ntlist, ntlist)

  end subroutine listing_writing_period_init

  !=============================================================================

end module entsor
