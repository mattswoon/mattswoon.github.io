import React from 'react'
import styled from 'styled-components'

const Wrapper = styled.div`
  margin: 10px;
  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
  transition: 0.3s;

  &:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
  }
`

const Title = styled.div`
  font-weight: 400;
  font-size: 150%;
`

const Description = styled.p`
  font-size: 90%;
  padding: 0px;
  margin: 0px;
`

const Container = styled.div`
  padding: 10px;
`

const Footer = styled.div`
`

const Card = ({title, description}) => (
  <Wrapper>
    <Container>
      <Title>{title}</Title>
      <Description>{description}</Description>
    </Container>
    <Footer></Footer>
  </Wrapper>
)


export default Card
