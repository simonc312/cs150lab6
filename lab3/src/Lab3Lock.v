//==============================================================================
//	File:		$URL: svn+ssh://repositorypub@repository.eecs.berkeley.edu/public/Projects/GateLib/branches/dev/Publications/Tutorials/Publications/EECS150/Labs/VerilogSynthesisAndFSMs/Files/Lab3Lock.v $
//	Version:	$Revision: 26904 $
//	Author:		Ilia Lebedev (ilial@berkeley.edu)
//				YOUR NAME GOES HERE
//	Copyright:	Copyright 2005-2010 UC Berkeley
//==============================================================================

//==============================================================================
//	Section:	License
//==============================================================================
//	Copyright (c) 2005-2010, Regents of the University of California
//	All rights reserved.
//
//	Redistribution and use in source and binary forms, with or without modification,
//	are permitted provided that the following conditions are met:
//
//		- Redistributions of source code must retain the above copyright notice,
//			this list of conditions and the following disclaimer.
//		- Redistributions in binary form must reproduce the above copyright
//			notice, this list of conditions and the following disclaimer
//			in the documentation and/or other materials provided with the
//			distribution.
//		- Neither the name of the University of California, Berkeley nor the
//			names of its contributors may be used to endorse or promote
//			products derived from this software without specific prior
//			written permission.
//
//	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//	ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//	WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//	DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//	ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//	(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//	LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//	ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//	SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//==============================================================================

//------------------------------------------------------------------------------
//	Module:		Lab3Lock
//	Desc:			This module implements the functionality of a simple combination lock.
//					The lock uses 2 4-bit combination digits.
//					See the lab document for the suggested combination setting.
//	Params:		This module is not parameterized.
//	Inputs:		See Lab3 document
//	Outputs:	See Lab3 document
//
//	Author:		<a href="http://www.gdgib.com/">Greg Gibeling</a>
//				YOUR NAME GOES HERE
//	Version:	$Revision: 26904 $
//------------------------------------------------------------------------------
module	Lab3Lock(
	//------------------------------------------------------------------
	//	Clock & Reset Inputs
	//------------------------------------------------------------------
	Clock,
	Reset,
	//------------------------------------------------------------------
	
	//------------------------------------------------------------------
	//	Inputs
	//------------------------------------------------------------------
	Enter,
	Digit,
	//------------------------------------------------------------------
	
	//------------------------------------------------------------------
	//	Outputs
	//------------------------------------------------------------------
	State,
	Open,
	Fail
	//------------------------------------------------------------------
);
	//--------------------------------------------------------------------------
	//	Parameters
	//--------------------------------------------------------------------------
	localparam	DIGIT_1	=	4'h2,
			DIGIT_2	=	4'h3;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Clock & Reset Inputs
	//--------------------------------------------------------------------------
	input					Clock;	// System clock
	input					Reset;	// System reset
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Inputs
	//--------------------------------------------------------------------------
	input					Enter;
	input		[3:0]		Digit;
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Outputs
	//--------------------------------------------------------------------------
	output	[2:0]		State;
	output				Open;
	output				Fail;
	//--------------------------------------------------------------------------

	//--------------------------------------------------------------------------
	//	State Encoding
	//--------------------------------------------------------------------------
	
	//place state encoding here
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Wire Declarations
	//--------------------------------------------------------------------------
	
	//place wire declarations here
	
	//--------------------------------------------------------------------------
	
	//--------------------------------------------------------------------------
	//	Logic
	//--------------------------------------------------------------------------
	
	
	// Place you *behavioral* Verilog here
	//	You may find it useful to use a case statement to describe your FSM.

	//--------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
