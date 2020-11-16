// File: contracts/interfaces/IEliteswapV2Router01.sol

pragma solidity >=0.6.2;

interface IEliteswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETH(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external returns (uint amountToken, uint amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountA, uint amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint liquidity,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint amountToken, uint amountETH);
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function swapExactETHForTokens(uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);
    function swapTokensForExactETH(uint amountOut, uint amountInMax, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapExactTokensForETH(uint amountIn, uint amountOutMin, address[] calldata path, address to, uint deadline)
        external
        returns (uint[] memory amounts);
    function swapETHForExactTokens(uint amountOut, address[] calldata path, address to, uint deadline)
        external
        payable
        returns (uint[] memory amounts);

    function quote(uint amountA, uint reserveA, uint reserveB) external pure returns (uint amountB);
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) external pure returns (uint amountOut);
    function getAmountIn(uint amountOut, uint reserveIn, uint reserveOut) external pure returns (uint amountIn);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

// File: contracts/test/RouterEventEmitter.sol

pragma solidity =0.6.6;


contract RouterEventEmitter {
    event Amounts(uint[] amounts);

    receive() external payable {}

    function swapExactTokensForTokens(
        address router,
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapExactTokensForTokens.selector, amountIn, amountOutMin, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }

    function swapTokensForExactTokens(
        address router,
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapTokensForExactTokens.selector, amountOut, amountInMax, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }

    function swapExactETHForTokens(
        address router,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapExactETHForTokens.selector, amountOutMin, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }

    function swapTokensForExactETH(
        address router,
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapTokensForExactETH.selector, amountOut, amountInMax, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }

    function swapExactTokensForETH(
        address router,
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapExactTokensForETH.selector, amountIn, amountOutMin, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }

    function swapETHForExactTokens(
        address router,
        uint amountOut,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable {
        (bool success, bytes memory returnData) = router.delegatecall(abi.encodeWithSelector(
            IEliteswapV2Router01(router).swapETHForExactTokens.selector, amountOut, path, to, deadline
        ));
        assert(success);
        emit Amounts(abi.decode(returnData, (uint[])));
    }
}
