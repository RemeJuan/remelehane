import React from "react";
import { Helmet } from "react-helmet";

export default ({ description, image, title, author }) => {
    return (
        <Helmet
            meta={[
                {
                    property: `og:title`,
                    content: title,
                },
                {
                    property: `og:description`,
                    content: description,
                },
                {
                    property: `og:type`,
                    content: `website`,
                },
                {
                    name: `twitter:creator`,
                    content: author,
                },
                {
                    name: `twitter:title`,
                    content: title,
                },
                {
                    name: `twitter:description`,
                    content: description,
                },
                {
                    property: "og:image",
                    content: image,
                },
                {
                    name: "twitter:card",
                    content: "summary_large_image",
                },
            ]}
        />
    );
}
