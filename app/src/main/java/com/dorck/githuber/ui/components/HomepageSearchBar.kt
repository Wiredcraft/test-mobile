package com.dorck.githuber.ui.components

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.text.BasicTextField
import androidx.compose.material.Icon
import androidx.compose.material.Text
import androidx.compose.material3.Surface
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.focus.onFocusChanged
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.res.stringResource
import androidx.compose.ui.text.input.TextFieldValue
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.dorck.githuber.R

val surfaceColor = Color(0XFFF5F5F5)
val unselectedIconColor = Color(0XFFBFBFBF)

@Composable
fun HomeSearchBar(
    modifier: Modifier = Modifier,
    query: TextFieldValue = TextFieldValue(),
    searchFocused: Boolean = false,
    onSearchFocusChange: ((Boolean) -> Unit)? = null,
    onClearQuery: (() -> Unit)? = null,
    searching: Boolean = false,
    onQueryChange: (TextFieldValue) -> Unit,
) {
    Surface(
        color = surfaceColor,
        shape = RoundedCornerShape(size = 26.dp),
        modifier = modifier
            .fillMaxWidth()
            .height(30.dp)
            .padding(horizontal = 20.dp)
    ) {
        Box(Modifier.fillMaxSize()) {
            if (query.text.isEmpty()) {
                SearchHint()
            }
            Row(
                verticalAlignment = Alignment.CenterVertically,
                modifier = Modifier
                    .fillMaxSize()
                    .wrapContentHeight()
                    .padding(start = 16.dp, end = 20.dp)
            ) {
                BasicTextField(
                    value = query,
                    maxLines = 1,
                    modifier = Modifier
                        .weight(1f)
                        .onFocusChanged {
                            onSearchFocusChange?.invoke(it.isFocused)
                        },
                    onValueChange = {
                        if (it.text.isNotBlank()) {
                            onQueryChange(it)
                        }
                    },
                )
                Icon(
                    painterResource(id = R.drawable.ic_search_outline),
                    tint = if (searchFocused) Color.Black else unselectedIconColor,
                    contentDescription = stringResource(R.string.search_icon_content_desc),
                    modifier = Modifier
                        .size(14.dp)
                        .padding()
                )
            }
        }
    }
}

@Composable
private fun SearchHint() {
    Box(
        contentAlignment = Alignment.CenterStart,
        modifier = Modifier
            .fillMaxSize()
            .padding(horizontal = 16.dp)
    ) {
        Text(
            text = stringResource(R.string.search_bar_hint_text),
            color = descriptionTextColor,
            maxLines = 1,
            fontSize = 12.sp
        )
    }
}

@Preview
@Composable
fun PreviewSearchBar() {
    HomeSearchBar(onQueryChange = { value -> })
}
